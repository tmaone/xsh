export conf

module conf

file_name = ASCIIString
command = ""
quiet = false
verbose = 0
debug_mode = 0
home_path = ""
interactive = false
login = false
daemon_only = false
ncpu = 0
print_expr = ""
color_mode = false
eval_expr = false
no_exec = false
no_history = false
no_startup = false

end

# export file_name, command, quiet, verbose, debug_mode, home_path, interactive, login, daemon_only, ncpu, print_expr, color_mode, eval_expr, no_exec, no_history, no_startup

# function __init__()

# # end
# export Config
# module Config
# import ..info

# info("Configuring Mocha...")
# const use_cuda_key = "MOCHA_USE_CUDA"
# const use_native_extension_key = "MOCHA_USE_NATIVE_EXT"

# if haskey(ENV, use_cuda_key) && lowercase(ENV[use_cuda_key]) != "false"
#   info(" * CUDA       enabled ($use_cuda_key environment variable detected)")
#   const use_cuda = true
# else
#   info(" * CUDA       disabled by default")
#   const use_cuda = false
# end

# if haskey(ENV, use_native_extension_key) && lowercase(ENV[use_native_extension_key]) != "false"
#   info(" * Native Ext enabled ($use_native_extension_key environment variable detected)")
#   const use_native_extension = true
# else
#   info(" * Native Ext disabled by default")
#   const use_native_extension = false
# end
# info("Mocha configured, continue loading module...")

# end


# if Config.use_native_extension
#   include("native.jl")
# end

# include("macros.jl")
# include("base.jl")
# include("exception.jl")

# include("utils/blas.jl")
# include("utils/math.jl")
# include("utils/io.jl")
# include("utils/tensor.jl")
# include("utils/ref-count.jl")

# if Config.use_native_extension
#   include("utils/im2col-native.jl")
# else
#   include("utils/im2col.jl")
# end

# include("backend.jl")
# include("blob.jl")

# if Config.use_cuda
#   include("cuda/cuda.jl")
#   include("cuda/cublas.jl")
#   include("cuda/cudnn.jl")
#   include("cuda/backend.jl")
#   include("cuda/blob.jl")
#   include("cuda/utils/math.jl")
#   include("cuda/utils/padded-copy.jl")
#   include("cuda/utils/shifted-copy.jl")
# end

# include("initializers.jl")
# include("regularizers.jl")
# include("constraints.jl")
# include("neurons.jl")

# if Config.use_cuda
#   include("cuda/regularizers.jl")
#   include("cuda/constraints.jl")
#   include("cuda/neurons.jl")
# end
# # RawBlameHistory   
# const POSSIBLE_AFFIXES = ["stem","prefix","suffix"]
# const RESTRICT_SEG_COUNTS = true
# const RESTRICT_TYPE_TAG_COUNTS = true
# const BOUNDARY_TOKEN = "~~"
# const MAX_SPANS = 4
# const MAX_AFFIX = 2
# const MODEL_STEM_POSITION = true
# const ALPHA_TAG_PRIOR = 0.1
# const ALPHA_EMISSION = 1e-5
# const ALPHA_TRANSITION = 1.0
# const CONFLICT_STEM_PROB = 1e-2
# const CONFLICT_LOG_ODDS = log(CONFLICT_STEM_PROB / (1.0 - CONFLICT_STEM_PROB))
# const ALPHA_SEG = 0.1
# const ALPHA_CLUSTER = .7
# const GAMMA_NUM_UNIQUE_SEGS = 1.0/10
# const GAMMA_SEG_LEN = 1.0/1.1
# const GAMMA_NUM_SEGS_PER_WORD = 1.0/3.0
# const GAMMA_AFFIX_PER_WORD = 1.0/2.0
# const LOG_GEOM_TRUNC_NUM_SEGS_PER_WORD = LogGeometricTruncated(GAMMA_NUM_SEGS_PER_WORD, MAX_SPANS)
# const LOG_GEOM_TRUNC_NUM_AFFIX_PER_WORD = LogGeometricTruncated(GAMMA_AFFIX_PER_WORD, MAX_AFFIX)
# const PAIRWISE_SUFFIX_LOGPROB = {nothing=>log(0.3), true=>log(0.6), false=>log(0.1)}
# const PAIRWISE_PREFIX_LOGPROB = {nothing=>log(0.05), true=>log(0.9), false=>log(0.05)}
# const USE_STEM_LENGTH_CONSTRAINT = true
# const X_GAMMA_NUM_UNIQUE_SEGS = {"stem"=>1e-4, "prefix"=>1.0/1.1, "suffix"=>1.0/1.1}
# const FROZEN_RE = r"^(\d)+"
# USER = get("USER")
# SHELL = get("SHELL")
# HOME = get("HOME")
# PATH = get("PATH")
# PWD = get("PWD")
# TERM = get("TERM")
# TMPDIR = get("TMPDIR")
# LANG = get("LANG")
# LC_ALL = get("LC_ALL")
# USER, SHELL, HOME, PATH, PWD, TERM, TMPDIR, LANG, LC_ALL,
# end
