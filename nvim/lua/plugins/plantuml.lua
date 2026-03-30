return { 
    'javiorfo/nvim-soil',
    dependencies = { 'javiorfo/nvim-nyctophilia' },
    lazy = true,
    ft = "plantuml",
    opts = {
        actions = {
            redraw = true -- Je conseille true pour que nsxiv se rafraîchisse quand tu sauvegardes
        },

        -- Supprime ou commente cette ligne si tu as plantuml installé sur Fedora
        -- puml_jar = "/path/to/plantuml.jar", 
        
        image = {
            darkmode = false,
            format = "png",
            execute_to_open = function(img) 
                -- On s'assure que nsxiv est bien appelé
                return "nsxiv -b " .. img
            end
        }
    }
}
