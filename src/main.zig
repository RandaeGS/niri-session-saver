const std = @import("std");
const niri_session_saver = @import("niri_session_saver");

pub fn main() !void {
    sayHello();
}

fn sayHello() void {
    std.debug.print("Hello World", .{});
}
