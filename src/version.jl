# import Base:
#     VersionNumber
# VERSION = VersionNumber(0,0,1,("git",),(0005,))
# module version
# end


## julia version info

# Include build number if we've got at least some distance from a tag (e.g. a release)
try
    build_number = GIT_VERSION_INFO.build_number != 0 ? "+$(GIT_VERSION_INFO.build_number)" : ""
    global const VERSION = convert(VersionNumber, "$(VERSION_STRING)$(build_number)")
catch e
    println("while creating Base.VERSION, ignoring error $e")
    global const VERSION = VersionNumber(0)
end
