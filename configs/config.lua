Config = {}

Config.Framework = 'qb' -- esx or qb

Config.Job = {

    {
        coords = vec3(-266.8483, -969.4417, 30.2175), -- coords for blip and ped
        heading = 297.6377, -- heading for ped
        ped = 'a_m_m_og_boss_01', -- spawn id for ped
        label = 'Job Center 1', -- label for blip and laben in menu
        blip = { enabled = true, sprite = 11, color = 11, scale = 0.75 }, -- true or false for show blip, sprite for blip, color for blip, scale for blip
        jobs = { -- list of jobs settings
            { job = 'police', job_grade = '0', label = 'police', description = ''}, -- job id, job grade, label what display in menu, description under the label
        }
    },

    {
        coords = vec3(-267.24, -968.58, 30.2175), -- coords for blip and ped
        heading = 297.6377, -- heading for ped
        ped = 'a_m_m_hasjew_01', -- spawn id for ped
        label = 'Job Center 2', -- label for blip and laben in menu
        blip = { -- blip settings
            enabled = true, -- true or false for show blip
            sprite = 11, -- sprite for blip
            color = 11, -- color for blip
            scale = 0.75 -- scale for blip
        },
        jobs = { -- list of jobs settings
            {
                job = 'ambulance', -- job id
                job_grade = '0', -- job grade
                label = 'ambulance', -- label what display in menu
                description = '' -- description under the label
            },
            {
                job = 'cardealer', -- job id
                job_grade = '0', -- job grade
                label = 'cardealer', -- label what display in menu
                description = 'be a seller' -- description under the label
            },
        }
    },

}