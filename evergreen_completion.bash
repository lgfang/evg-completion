# \file Name: evergreen_compeletion.bash
# Created:  Lungang Fang 2023-06-23
# Modified: Lungang Fang 2023-07-03T16:23:00+1000>

# \brief

# \details

# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2, or (at your option) any later
# version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.

# Had you not received a copy of the GNU General Public License yet, write
# to the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

function __comp_evergreen () {
    local i=1 cur prev command options

    COMPREPLY=()
    command=${COMP_WORDS[1]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    cur=${COMP_WORDS[COMP_CWORD]}

    commands=(
        "admin"
        "agent"
        "buildlogger"
        "cancel-patch"
        "client"
        "commit-queue"
        "create-version"
        "evaluate"
        "fetch"
        "finalize-patch"
        "get-update"
        "help"
        "host"
        "keys"
        "last-green"
        "list"
        "list-patches"
        "notify"
        "patch"
        "patch-file"
        "patch-remove-module"
        "patch-set-module"
        "pull"
        "scheduler"
        "service"
        "subscriptions"
        "validate"
        "version"
        "volume"
    )

    if [[ "$COMP_CWORD" -eq 1 ]]; then
        # shellcheck disable=SC2207
        COMPREPLY=($(compgen -W "${commands[*]}" -- "$cur"))
    else
        case "$command" in
            buildlogger)
                options=("fetch" "--task_id" "--execution")
                ;;
            patch) _comp_evg_patch ;;
            fetch) _comp_evg_fetch ;;
        esac

        # Assuming no command/sub-command/options will be used more than once in
        # the command line, delete the ones have already entered from the
        # completion list.
        for each in "${COMP_WORDS[@]}"; do
            for i in "${!options[@]}"; do
                if [[ "$each" == "${options[i]}" ]]; then
                    unset "options[i]"
                fi
            done
        done

        # shellcheck disable=SC2207
        COMPREPLY=($(compgen -W "${options[*]}" -- "$cur"))
    fi
}

function _comp_evg_patch () {

    case "$prev" in
        "--project")
            options=($(evergreen list --projects | while read -r line; do echo ${line%% *};done))
            ;;
        "--variants")
            # TODO: List variants if projects is already specified, otherwise empty completion list.
            ;;
        "--description")
            # Do *not* provide completion for description
            ;;
        *)
            case "$cur" in
                *)
                    options=(
                        "--include-modules"
                        "--project"
                        "--finalize"
                        "--variants"
                        "--param"
                        "--browse"
                        "--sync_variants"
                        "--sync_tasks"
                        "--sync_statuses"
                        "--sync_timeout"
                        "--large"
                        "--skip_confirm"
                        "--ref"
                        "--uncommitted"
                        "--repeat"
                        "--repeat-failed"
                        "--repeat-patch"
                        "--tasks"
                        "--alias"
                        "--description"
                        "--auto-description"
                        "--verbose"
                        "--trigger-alias"
                        "--path"
                        "--regex_variants"
                        "--regex_tasks"
                        "--preserve-commits")
                ;;
        esac
    esac

}

function _comp_evg_fetch () {
    case "$prev" in
        --dir|-d)
        # Do not provide completion.
        ;;
        *)
          case "$cur" in
              *)
                  options=(
                      "--dir"
                      "--task"
                      "--token"
                      "--source"
                      "--artifacts"
                      "--shallow"
                      "--patch"
                  );;

          esac
    esac

}

complete -F __comp_evergreen evergreen
complete -F __comp_evergreen evg
