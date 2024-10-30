const std = @import("std");
const Menu = @import("menu");
const Menu_options = @import("menu_options"); //remember to import your options

// const semver = std.SemanticVersion.parse(Menu_options.menu_choice) catch unreachable;

pub fn main() !void {
    // if (semver.major < 1) {
    //     @compileError("too old");
    // }

    const my_menu = Menu.fromString(Menu_options.menu_choice);
    // std.debug.print("\n MAIN: {any} ", .{my_menu});

    print_my_menu(my_menu);
}

pub inline fn print_my_menu(my_menu: Menu.Menu_list) void {
    std.debug.print("\n ----You chose {any} menu!!!\n\n", .{my_menu});
}
