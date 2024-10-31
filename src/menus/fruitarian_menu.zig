const std = @import("std");

pub fn printMenu() void {
    std.debug.print("\n ----You chose vegan menu!!!", .{});
    std.debug.print("\n ----    apple", .{});
    std.debug.print("\n ----    orange", .{});
    std.debug.print("\n ----    tomato\n\n", .{});
}
