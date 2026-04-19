const std = @import("std");
const niri_session_saver = @import("niri_session_saver");

pub fn main() !void {
    try processMainDirectory();
}

fn processMainDirectory() !void {
    const allocator = std.heap.page_allocator;

    const home = try std.process.getEnvVarOwned(allocator, "HOME");
    const configFile = "/.config/niri-session-saver/config.json";
    const dir = &[_][]const u8{ home, configFile };

    const joined = try std.mem.concat(allocator, u8, dir);

    std.log.info("Config file {s}", .{joined});
    std.fs.accessAbsolute("/home/randaegs/.config/niri-session-saver/config.json", .{}) catch |err| {
        if (err == error.FileNotFound) {
            std.log.info("Config file not found. Creating one...", .{});
            try createConfigFile();
            return;
        }
        return;
    };
}

fn createConfigFile() !void {
    const file = try std.fs.cwd().createFile("test_file.txt", .{ .read = true });
    defer file.close();

    std.log.info("Config file {any}", .{file});
}
