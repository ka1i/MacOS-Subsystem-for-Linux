import Foundation
import Virtualization

public func TerminalSerial() -> VZSerialPortConfiguration {
    let serial = VZVirtioConsoleDeviceSerialPortConfiguration()

    let stdin = FileHandle.standardInput
    let stdout = FileHandle.standardOutput

    // Put stdin into raw mode, disabling local echo, input canonicalization,
    // and CR-NL mapping.
    var attributes = termios()
    tcgetattr(stdin.fileDescriptor, &attributes)
    attributes.c_iflag &= ~tcflag_t(ICRNL)
    attributes.c_lflag &= ~tcflag_t(ICANON | ECHO)
    tcsetattr(stdin.fileDescriptor, TCSANOW, &attributes)

    serial.attachment = VZFileHandleSerialPortAttachment(fileHandleForReading: stdin,fileHandleForWriting: stdout)

    return serial
}