const std = @import("std");
const Menu = @import("src/menu.zig");
const Menu_list = @import("src/menu.zig").Menu_list;

pub fn build(b: *std.Build) void {
    // Set target options, such as architecture and OS.
    const target = b.standardTargetOptions(.{});

    // Set optimization level (debug, release, etc.).
    const optimize = b.standardOptimizeOption(.{});

    //************************************************MODULE CREATION************************************************
    const menu_mod = b.createModule(.{ .root_source_file = b.path("src/menu.zig") });

    //************************************************MAIN EXECUTABLE************************************************

    // Define the main executable with target architecture and optimization settings.
    const exe = b.addExecutable(.{
        .name = "Main",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibC();

    //************************************************EXE DEPENDENCIES************************************************
    exe.root_module.addImport("menu", menu_mod);

    //************************************************ENABLE OPTIONS************************************************
    //declaring option voices
    const menu_choice_str = b.option([]const u8, "menu", "wich menu you chose") orelse "standard"; //So -Dmenu ... is how you select your choice
    //enable option usage
    const menu_options = b.addOptions();
    // //convert menu_choice_str into an enum
    // const menu_choice_enum = Menu.fromString(menu_choice_str);
    //add the specific option for menu choice, it can be called by importing "menu_options"
    menu_options.addOption([]const u8, "menu_choice", menu_choice_str); // -> we are forced to pass a []const u8

    std.debug.print("\n BUILD: menu_choice_enum:{any} ", .{menu_choice_str});

    //adding the options to the exe (aka main.zig)
    exe.root_module.addOptions("menu_options", menu_options);

    //************************************************INSTALLING AND RUNNING************************************************
    // Install the executable.
    b.installArtifact(exe);

    // Define the run command for the main executable.
    const run_cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // Create a build step to run the application.
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_cmd.step);
}
