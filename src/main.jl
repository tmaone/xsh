export main

# import Base:
# REPL,
# Terminals,
# Vector,
# println,
# STDIN,
# STDOUT,
# STDERR,
# pushdisplay,
# VersionNumber,
# print,
# source_path,
# Dict

import ..conf
using ..util

using ArgParse
# # test if the program works
# # load all necessary files
# load("maths.jl")
# load("maths.jl")
# load("config.jl")
# load("wordstate.jl")
# load("helper.jl")
# load("lexicon.jl")
# load("gibbs_sampler.jl")
# load("run_all.jl")
# load("blade_runner.jl")

# data_dir = "data-sample/"
# out_prefix = "model-"
# out_dir = "models/"

# book = "new_wordlist.eng"
# filename = "$(data_dir)$(book)"
# outdict = "$(out_dir)$(out_prefix)$(book)"
# gold_cols = read_data(filename)
# cluster_file = "cluster-embedding.eng"

# gold_tags = nothing
# hyperparameters = Dict()
# seq = false
# suffix = false
# prefix = false
# num_processes = 1
# numit = 30
# num_tags = 1
# fix_tags = false
# fix_segs = false
# fix_stem = false
# init_tag = "uniform"
# init_seg = "whole-word"
# init_stem = "first"
# state0 = nothing
# sep_lex_size = true
# flags = nothing
# phrase_counts = gold_cols[1]
# phrases = gold_cols[2]
# gold = gold_cols[2]
# cluster = nothing
# outdicts_state = "$(outdict)-state"
# params = Params(phrase_counts, cluster, phrases, gold, gold_tags, seq, suffix, prefix, numit, fix_tags, fix_segs, fix_stem, init_tag, init_seg, init_stem, num_tags, state0, outdicts_state, sep_lex_size)
# run_all(params)


const arg_parse_settings = ArgParseSettings(
    prog=XSH_BIN,
    description=XSH_ARG_DESCRIPTION, 
    epilog=XSH_ARG_EPILOGUE, 
    usage = XSH_ARG_USAGE,
    version = "$(VERSION)",
    add_help = false, 
    add_version = false,
    commands_are_required = false,
    autofix_names = true, 
    suppress_warnings = true,
    allow_ambiguous_opts = true
    )

arg_parse_data = Dict{Symbol, UTF8String}()

function init_arg_table()

    @add_arg_table arg_parse_settings begin
        "file"
        help = "Evaluate xsh script"
        "cmd"
        help = "Run command"
        action = :command
        "--help", "-h"
        help = "Print this message"
        action = :show_help
        "--version", "-v"
        help = "Display version information"
        action = :show_version
        "--quiet", "-q"
        help = "Quiet operation, only errors"
        action = :store_true
        "--verbose", "-V"
        help = "Specify verbosity level, 0≦V≦5 Default level [1]"
        action = :store_true
        "--debug", "-d"
        help = "Enable debug output"
        action = :store_true
        "--home", "-H"
        help = "Set the location of xsh home"
        action = :store_true
        "--interactive", "-i"
        help = "Run in interactive mode"
        action = :store_true
        "--login", "-l"
        help = "Run as a login shell"
        action = :store_true
        "--daemon", "-m"
        help = "Run and detach xsh daemon, then exit"
        action = :store_true
        "--ncpu", "-n"
        help = "Run [n] local processes"
        action = :store_true
        "--print", "-E"
        help = "Evaluate and show <cmd>"
        action = :store_true
        "--color", "-c"
        help = "Enable or disable color text"
        action = :store_true
        "--eval", "-e"
        help = "Evaluate <expr>"
        action = :store_true
        "--no-exec"
        help = "Do not execute, only perform syntax checking"
        action = :store_true
        "--no-history-file"
        help = "Do not archive command history"
        action = :store_true
        "--no-startup"
        help = "Do not load user start-up script [~/.xshrc]"
        action = :store_true
    end
end

function active(val::ANY)
    if val == false
        return false
    end
    if val == nothing
        return false
    end
    return true
end

function parse_argument(key::ASCIIString, value::ANY)
    @switch key begin
        @case "home"
        # xsh_config.home_path = value
        break
        @case "login"
        # xsh_config.login = value
        break
        @case "no_exec"
        # xsh_config.no_exec = value
        break
        @case "no_history_file"
        # xsh_config.no_history = value     
        break
        @case "quiet"
        # xsh_config.quiet = value   
        break
        @case "interactive"
        # xsh_config.interactive = value   
        break
        @case "eval"
        # println("eval")
        break
        @case "debug"
        # xsh_config.debug_mode = value   
        break
        @case "verbose"
        # xsh_config.verbose = value   
        break
        @case "no_startup"
        # xsh_config.no_startup = value   
        break
        @case "daemon"
        # xsh_config.daemon_only = value   
        break
        @case "print"
        # println("print")
        break
        @case "file"
        print("file : $(value)")
        conf.file_name = value
        print("$(file_name) : $(value)")
        print("$(conf.file_name) : $(value)")
        break
        @case "color"
        # xsh_config.color_mode = value   
        break
        @case "ncpu"
        # xsh_config.ncpu = value   
        break
        @default
        println("Not Found [$(key)][$(value)]")
    end
end

function parse_args(args::Vector{UTF8String}=UTF8String[])
    parsed_args =ArgParse.parse_args(args, arg_parse_settings)
    for (key,val) in parsed_args
        if active(val)
            parse_argument(key, val)
        end
    end
end

function __init__()
    init_arg_table()
end

function main(args::Vector{UTF8String}=UTF8String[])
    println(XSH_DESCRIPTION)
    parsed_args = parse_args(args)
    println(conf.file_name)
    println(file_name)
    # dump(config)
end
