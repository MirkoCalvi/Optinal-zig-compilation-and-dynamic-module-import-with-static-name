const std = @import("std");
const x_menu = @import("x_menu");

pub const Menu_list = enum {
    Normal,
    Fruitarian,
    Vegan,
    Megan,
};

pub fn fromString(value: []const u8) Menu_list {
    if (std.mem.eql(u8, value, "fruitarian")) {
        return Menu_list.Fruitarian;
    } else if (std.mem.eql(u8, value, "vegan")) {
        return Menu_list.Vegan;
    } else if (std.mem.eql(u8, value, "megan")) {
        return Menu_list.Megan;
    } else {
        return Menu_list.Normal;
    }
}

pub fn printMenu() void {
    x_menu.printMenu();
}
