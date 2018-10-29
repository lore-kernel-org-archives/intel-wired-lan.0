From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 29 Oct 2018 09:00:48 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] kconfig: remove silentoldconfig
 target
In-Reply-To: <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
References: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
 <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <c7970686b40e5348b2351580b19f45ee6edc12a9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2018-10-30 at 00:41 +0900, Masahiro Yamada wrote:
> As commit 911a91c39cab ("kconfig: rename silentoldconfig to
> syncconfig") announced, it is time for the removal.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/networking/ice.rst | 2 +-
>  scripts/kconfig/Makefile         | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the ice driver documentation change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181029/4a1989be/attachment.asc>
