# climate.sh - run Climate in DevStack

if is_service_enabled climate; then
    case "$1" in
        source )
            # NOTE: Yes, I'm hardcoding this URLs here. I know it's bad. Hit me.
            CLIMATE_REPO=${CLIMATE_REPO:-${GIT_BASE}/DinaBelova/climate.git}
            CLIMATE_BRANCH=${CLIMATE_BRANCH:-master}
            CLIMATECLIENT_REPO=${CLIMATECLIENT_REPO:-${GIT_BASE}/DinaBelova/python-climateclient.git}
            CLIMATECLIENT_BRANCH=${CLIMATE_BRANCH:-master}
            source $TOP_DIR/lib/climate
            ;;
        stack )
            case "$2" in
                install )
                    echo_summary "Installing Climate"
                    install_climate
                    install_climateclient
                    ;;
                post-config )
                    echo_summary "Configuring Climate"
                    configure_climate
                    init_climate
                    create_climate_accounts
                    ;;
                extra )
                    echo_summary "Starting Climate"
                    # Just so that we have utterly pretty localrc
                    enable_sevice cli-api
                    enable_sevice cli-man
                    start_climate
                    ;;
            esac
            ;;
        unstack )
            echo_summary "Stopping Climate"
            stop_climate
            ;;
        clean )
            echo_summary "Cleaning Climate"
            cleanup_climate
            ;;
    esac
fi
