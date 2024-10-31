const std = @import("std");

pub fn printMenu() void {
    std.debug.print("\n ----You chose normal menu!!!", .{});
    std.debug.print("\n ----    pasta", .{});
    std.debug.print("\n ----    cheese", .{});
    std.debug.print("\n ----    books\n\n", .{});
}
