From: Edward Cree <ecree@solarflare.com>
Date: Sat, 12 Sep 2020 00:11:20 +0100
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <20200911152642.62923ba2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
 <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
 <20200911144207.00005619@intel.com>
 <e2e637ae-8cda-c9a4-91ce-93dbd475fc0c@solarflare.com>
 <20200911152642.62923ba2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <115bce2a-daaa-a7c5-3c48-44ce345ea008@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/09/2020 23:26, Jakub Kicinski wrote:
> "Toolchain" sounds a little grand in this context, the script that
> parses kdoc does basic regexps to convert the standard kernel macros:
> ...
> IDK if we can expect it to understand random driver's macros..
I wasn't suggesting it should _understand_ this macro, justrecognise
?when something _is_ a macro it doesn't understand, and refrain from
?warning about it in that case.
But I don't know how hard that would be to achieve ? not being fluent
?in Perl, scripts/kernel-doc is mostly line noise to me.? My best
?guess is that on seeing 'DECLARE_A_THING(name, argument);' it reads
?it as though it were 'DECLARE_A_THING name, argument;', mistaking
?the macro name for a type.
I think the only way non-macro declarations can legitimately contain
?parens is in function pointer types, in which case the contents of
?the parens are part of the type and not declared identifiers.? So
?shouldn't kernel-doc ignore anything within parens?
> This is the only use of _MCDI_DECLARE_BUF() in the tree
Well, except for mcdi.h's
??? #define MCDI_DECLARE_BUF(_name, _len) _MCDI_DECLARE_BUF(_name, _len) = {{{0}}}
> , how about converting the declaration to:
>
> #declare _MCDI_BUF_LEN(_len)   DIV_ROUND_UP(_len, 4)
>
> 	efx_dword_t txbuf[_MCDI_BUF_LEN(MC_CMD_PTP_IN_TRANSMIT_LENMAX)];
>
> Would that work?
That could work, yes.? Though, probably lose the leading underscore
?in that case.

-ed
