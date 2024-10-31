const std = @import("std");

pub fn printMenu() void {
    std.debug.print("\n ----You chose Megan menu!!!", .{});
    std.debug.print("\n ----    eyes", .{});
    std.debug.print("\n ----    a leg", .{});
    std.debug.print("\n ----    oh nooo.. you just kill Megan\n\n", .{});
}
