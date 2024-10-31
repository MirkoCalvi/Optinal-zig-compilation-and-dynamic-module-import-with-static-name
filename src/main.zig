const std = @import("std");
const Menu = @import("menu");
const Menu_options = @import("menu_options"); //remember to import your options

pub fn main() !void {

    //HERE I SHOW HOW TO ACCESS AN "OPTION", see Menu_options in build.zig
    const my_menu = Menu.fromString(Menu_options.menu_choice);
    print_my_menu(my_menu);

    //HERE I SHOW HOW CONDITIONAL COMPILATION WORKS, see switch(menu_choice_enum) in build.zig
    print_x_menu();
}

pub inline fn print_my_menu(my_menu: Menu.Menu_list) void {
    std.debug.print("\n ----You chose {any} menu!!!\n\n", .{my_menu});
}

pub inline fn print_x_menu() void {
    Menu.printMenu();
}
