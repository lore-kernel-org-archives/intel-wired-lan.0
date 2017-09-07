From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 06 Sep 2017 18:13:18 -0700
Subject: [Intel-wired-lan] [PATCH net 2/2] i40e: Avoid some useless
 variables and initializers in nvm functions
In-Reply-To: <d0881adf53a3f0a546b3e7940b92b4ce938e7e50.1504684488.git.sbrivio@redhat.com>
References: <cover.1504684488.git.sbrivio@redhat.com>
 <d0881adf53a3f0a546b3e7940b92b4ce938e7e50.1504684488.git.sbrivio@redhat.com>
Message-ID: <1504746798.3922.80.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-09-06 at 10:11 +0200, Stefano Brivio wrote:
> Fixes: 09f79fd49d94 ("i40e: avoid NVM acquire deadlock during NVM
> update")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

This is NOT a fix, it is a coding style preference whether or not you
like multiple returns or a single return in functions.  I do not mind
picking this up for net-next (4.15 kernel), but this does not qualify
for a fix for Dave's net tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170906/b948ff49/attachment.asc>
