module MCollective
    module Agent
        class Localyaml<RPC::Agent
            def startup_hook
                meta[:license] = "Apache License 2.0"
                meta[:author] = "Jared Brothers"
                meta[:version] = "0.1"

                timeout = 10
                @name = @config.pluginconf["puppet.nodeyaml"] ||
                    "/etc/puppet/node.yaml"
            end

            action "save" do
                node = request[:node]
                begin
                    unless File.exists?(@name)
                        file = File.new(@name, "w", 0600)
                    else
                        file = File.open(@name, "w")
                        file.chmod(0600)
                    end
                    file.puts(node)
                    file.close()
                    reply[:written] = 1
                rescue
                    reply.fail "Could not write " + @name
                end
            end
        end
    end
end

# vi:tabstop=4:expandtab:ai:filetype=ruby
