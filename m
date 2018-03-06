From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 18:39:30 +0900
Subject: [Intel-wired-lan] [PATCH v3 2/2] kconfig: rename
 silentoldconfig to syncconfig
In-Reply-To: <1519886077-31914-2-git-send-email-yamada.masahiro@socionext.com>
References: <1519886077-31914-1-git-send-email-yamada.masahiro@socionext.com>
 <1519886077-31914-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARM_1fXyh8hnnAw7DGC97LZ7-pcriqWC9gQ4uSnU==Vpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2018-03-01 15:34 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> As commit cedd55d49dee ("kconfig: Remove silentoldconfig from help
> and docs; fix kconfig/conf's help") mentioned, 'silentoldconfig' is a
> historical misnomer.  That commit removed it from help and docs since
> it is an internal interface.  If so, it should be allowed to rename
> it to something more intuitive.  'syncconfig' is the one I came up
> with because it updates the .config if necessary, then synchronize
> include/generated/autoconf.h and include/config/* with it.
>
> You should not manually invoke 'silentoldcofig'.  Display warning if
> used in case existing scripts are doing wrong.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v3:
>   - Fix Documentation/networking/i40e.txt
>   - Display warning if silentoldconfig is used
>
> Changes in v2:
>   - newly added
>

Both applied to linux-kbuild/kconfig.


-- 
Best Regards
Masahiro Yamada
