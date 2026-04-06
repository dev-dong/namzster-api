create table if not exists login
(
    user_id     varchar(32) not null
        primary key,
    user_passwd varchar(32) null,
    user_type   varchar(10) null
);

insert ignore into login (user_id, user_passwd, user_type)
values ('admin', 'admin987', 'admin');

create table if not exists data
(
    db_id               varchar(255)                not null
        primary key,
    wav_dur_sec         decimal(10, 2) default 0.00 null,
    assigned_dur_sec    decimal(10, 2) default 0.00 null,
    submit_dur_sec      decimal(10, 2) default 0.00 null,
    worker_save_dur_sec decimal(10, 2) default 0.00 null,
    edit_dur_sec        decimal(10, 2) default 0.00 null,
    editor_save_dur_sec decimal(10, 2) default 0.00 null
);

create table if not exists editor
(
    editor_id       varchar(32)                 not null
        primary key,
    edit_ct         int            default 0    null,
    save_ct         int            default 0    null,
    assign_dur_sec  decimal(10, 2) default 0.00 null,
    edit_dur_sec    decimal(10, 2) default 0.00 null,
    save_dur_sec    decimal(10, 2) default 0.00 null,
    recent_datetime datetime                    null
);

create table if not exists worker
(
    worker_id       varchar(32)                 not null
        primary key,
    assign_ct       int            default 0    null,
    work_ct         int            default 0    null,
    save_ct         int            default 0    null,
    assign_dur_sec  decimal(10, 2) default 0.00 null,
    submit_dur_sec  decimal(10, 2) default 0.00 null,
    save_dur_sec    decimal(10, 2) default 0.00 null,
    recent_datetime datetime                    null
);

create table if not exists folder
(
    folder_id              varchar(255)                not null
        primary key,
    db_id                  varchar(255)                null,
    tot_ct                 int            default 0    null,
    wav_dur_sec            decimal(10, 2) default 0.00 null,
    worker_id              varchar(32)                 null,
    work_ct                int            default 0    null,
    submit                 tinyint(1)     default 0    null,
    save_dur_sec           decimal(10, 2) default 0.00 null,
    assign_datetime        datetime                    null,
    submit_datetime        datetime                    null,
    editor_id              varchar(255)                null,
    edit_ct                int            default 0    null,
    editor_submit          tinyint(1)     default 0    null,
    edit_dur_sec           decimal(10, 2) default 0.00 null,
    editor_submit_datetime datetime                    null,
    editor_assign_datetime datetime                    null,
    constraint folder_ibfk_1
        foreign key (db_id) references data (db_id),
    constraint folder_ibfk_2
        foreign key (worker_id) references worker (worker_id)
);

create index db_id
    on folder (db_id);

create index wiIdx
    on folder (worker_id);

create table if not exists static
(
    id             int auto_increment
        primary key,
    db_id          varchar(255)   null,
    folder_id      varchar(255)   null,
    folder_row_num int            null,
    wavpath        varchar(255)   null,
    input_text     longtext       null,
    wav_dur_sec    decimal(10, 2) null,
    constraint uniqItem
        unique (folder_id, folder_row_num),
    constraint wavpath
        unique (wavpath),
    constraint static_ibfk_1
        foreign key (folder_id) references folder (folder_id)
);

create table if not exists response
(
    id              int                  not null
        primary key,
    worker_id       varchar(32)          null,
    worker_response longtext             null,
    worker_deleted  tinyint(1) default 0 null,
    work_datetime   datetime             null,
    editor_id       varchar(32)          null,
    editor_response longtext             null,
    editor_deleted  tinyint(1) default 0 null,
    edit_datetime   datetime             null,
    constraint response_ibfk_1
        foreign key (id) references static (id)
);

create index editIdx
    on response (work_datetime, edit_datetime);
