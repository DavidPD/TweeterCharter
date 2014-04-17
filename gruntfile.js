module.exports = function(grunt)
{
    grunt.initConfig(
    {
        pkg: grunt.file.readJSON('package.json'),
        watch:
        {
            pages:
            {
                files: ['site/*.html','site/css/*.css','site/js/*.js'],
                options:
                {
                    livereload: true
                }
            },
            coffee:
            {
                files: ["site/coffee/*.coffee"],
                tasks: ["coffee"]
            }
        },
        coffee:
        {
            compile: 
            {
                options: {bare:true},
                expand: true,
                flatten: true,
                cwd: "site/coffee/",
                src: ['*.coffee'],
                dest: 'site/js/',
                ext: '.js',
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    grunt.registerTask('default', ['watch','coffee']);
}
