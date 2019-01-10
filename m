From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 10 Jan 2019 10:54:46 -0800
Subject: [Intel-wired-lan] [PATCH] iavf: Use printf instead of
 gnu_printf for iavf_debug_d
In-Reply-To: <20190110042157.8445-1-natechancellor@gmail.com>
References: <20190110042157.8445-1-natechancellor@gmail.com>
Message-ID: <CAKwvOdk=GZUG3FdP1gDg30H_Tt52cPXrZC-4Na8ZfD0h=jbU8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 9, 2019 at 8:22 PM Nathan Chancellor
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

Thanks for this fix!
FWIW, using godbolt to see which version something was added in is
better than giving a year of the commit.  I don't think it matters for
this case, as the kernel already makes use of `printf` as you do in
this change, but food for thought for next time.

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
> ---
>  drivers/net/ethernet/intel/iavf/iavf_osdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> index e6e0b0328706..c90cafb526d0 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> @@ -46,7 +46,7 @@ struct iavf_virt_mem {
>
>  #define iavf_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
>  extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
> -       __attribute__ ((format(gnu_printf, 3, 4)));
> +       __printf(3, 4);

And you make use of the __attribute__ wrapper from
include/linux/compiler_attributes.h, cool.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
