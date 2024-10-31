const std = @import("std");

pub fn printMenu() void {
    std.debug.print("\n ----You chose vegan menu!!!", .{});
    std.debug.print("\n ----    carrots", .{});
    std.debug.print("\n ----    broccoli", .{});
    std.debug.print("\n ----    wood\n\n", .{});
}
