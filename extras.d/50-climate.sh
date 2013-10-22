# climate.sh - run Climate in DevStack

if is_service_enabled cli-api || is_service_enabled cli-man; then
    case "$1" in
        source )
            # NOTE: Yes, I'm hardcoding this URLs here. I know it's bad. Hit me.
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
                    ;;
                extra )
                    echo_summary "Starting Climate"
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
