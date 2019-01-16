From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Jan 2019 23:38:27 +0100
Subject: [Intel-wired-lan] [PATCH] iavf: Use printf instead of
 gnu_printf for iavf_debug_d
In-Reply-To: <20190110042157.8445-1-natechancellor@gmail.com>
References: <20190110042157.8445-1-natechancellor@gmail.com>
Message-ID: <CANiq72kO233qL0Yqv4iSW7_4MGxmijrLF8bRwzKacsMVyOLKQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Nathan,

On Thu, Jan 10, 2019 at 5:22 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> In file included from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
> In file included from drivers/net/ethernet/intel/iavf/iavf.h:37:
> In file included from drivers/net/ethernet/intel/iavf/iavf_type.h:8:
> drivers/net/ethernet/intel/iavf/iavf_osdep.h:49:18: warning: 'format' attribute argument not supported: gnu_printf [-Wignored-attributes]
>         __attribute__ ((format(gnu_printf, 3, 4)));
>                         ^
> 1 warning generated.
>
> We can convert from gnu_printf to printf without any side effects for
> two reasons:
>
> 1. All iavf_debug instances use standard printf formats, as pointed out
>    by Miguel Ojeda at the below link, meaning gnu_printf is not strictly
>    required.
>
> 2. However, GCC has aliased printf to gnu_printf on Linux since at least
>    2010 based on git history.
>
>    From gcc/c-family/c-format.c:
>
>    /* Attributes such as "printf" are equivalent to those such as
>       "gnu_printf" unless this is overridden by a target.  */
>    static const target_ovr_attr gnu_target_overrides_format_attributes[] =
>    {
>      { "gnu_printf",   "printf" },
>      { "gnu_scanf",    "scanf" },
>      { "gnu_strftime", "strftime" },
>      { "gnu_strfmon",  "strfmon" },
>      { NULL,           NULL }
>    };
>
> The mentioned override only happens on Windows (mingw32). Changing from
> gnu_printf to printf is a no-op for GCC and stops Clang from warning.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/111
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I forgot, in case you wanted it:

    Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks for taking care of writing the patch!

Cheers,
Miguel
