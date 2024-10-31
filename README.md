# Menu Selection Build Script

This Zig build script dynamically builds an executable with options for selecting various menus. By using this script, you can specify a menu at build time (e.g., vegan, fruitarian, etc.), which will adjust the program to include specific menu modules based on your choice.

## How It Works

### Overview
The script sets up the necessary options and modules to build an executable that includes different menu options. The following actions are performed:
- Target architecture and optimization settings are defined.
- A module for each menu type is created.
- The chosen menu is selected through an option at build time, converted to an enum for cleaner code, and the respective module is imported.
- The main executable is built with these settings, linking the necessary modules.

## Code Breakdown

### Import Statements
- **`std`**: The Zig standard library for basic functions and utilities.
- **`Menu`** and **`Menu_list`**: Modules for handling and enumerating menu options.

### Build Function
The main function, `build`, configures and compiles the executable.

#### Step 1: Target and Optimization Settings
    
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    
This sets the target (architecture and OS) and optimization level (debug or release) for the build.

#### Step 2: Module Creation

    const menu_mod = b.createModule(.{ .root_source_file = b.path("src/menus/menu.zig") });

This section creates Zig modules for each available menu type:

- menu.zig
- vegan_menu.zig
- megan_menu.zig
- normal_menu.zig
- fruitarian_menu.zig

Each module represents a different menu type, with a main menu.zig file that dynamically imports the selected menu.

#### Step 3: Enabling Menu Options

    const menu_choice_str = b.option([]const u8, "menu", "which menu you chose") orelse "standard";

**menu_choice_str** stores the selected menu as a string, which you set by passing **`-Dmenu=<menu_choice>`** when building.

**Options Setup:** **`menu_options.addOption`** allows adding a menu_choice string option to the executable. This could not be set directly with an enum due to limitations.

#### Step 4: Menu Selection Logic

    const menu_choice_enum = Menu.fromString(menu_choice_str);

The **`menu_choice_str`** string is converted to a menu_choice_enum, an enum value for more readable code.

A switch statement then imports the appropriate menu module based on the selected enum:

    Vegan -> imports vegan_menu_mod
    Fruitarian -> imports fruitarian_menu_mod
    Megan -> imports megan_menu_mod
    Other -> imports normal_menu_mod (default)

**OSS : each menu file is always imported into menu_x**

     menu_mod.addImport("x_menu", <your_menu_mod>);

#### Step 5: Main Executable Setup

    const exe = b.addExecutable(.{
        .name = "Main",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibC();

Creates the main executable called Main with target architecture and optimization settings.
Links with the C standard library (libc), allowing access to common C functions.

#### Step 6: Adding Dependencies and Options to Executable

    exe.root_module.addImport("menu", menu_mod);
    exe.root_module.addOptions("menu_options", menu_options);

menu_mod is added as an import, allowing the main executable to access the dynamically selected menu.
menu_options are added to the executable, allowing runtime access to the chosen menu option.

#### Step 7: Installing and Running

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);

Installs the exe as a runnable artifact.
Sets up a run command, allowing the executable to be run after the build process completes.

# Usage

To use this script, specify the desired menu option at build time with -Dmenu=<menu_name>, for example:

    zig build -Dmenu=vegan

This command compiles the program, linking in the **`vegan_menu.zig`** module.

The **default** menu is standard if no specific menu is provided.

### Dependencies

Each menu option should have a corresponding Zig file in the src/menus directory. For instance:

    vegan_menu.zig
    megan_menu.zig
    normal_menu.zig
    fruitarian_menu.zig

These files are dynamically linked based on the menu_choice specified at build time.