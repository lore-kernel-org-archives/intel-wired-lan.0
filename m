From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 06 Sep 2017 18:16:11 -0700
Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: Fix comment about
 locking for __i40e_read_nvm_word()
In-Reply-To: <4d27bbb33031ac1489fe6d969edd74d44155136c.1504684488.git.sbrivio@redhat.com>
References: <cover.1504684488.git.sbrivio@redhat.com>
 <4d27bbb33031ac1489fe6d969edd74d44155136c.1504684488.git.sbrivio@redhat.com>
Message-ID: <1504746971.3922.83.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-09-06 at 10:11 +0200, Stefano Brivio wrote:
> Caller needs to acquire the lock. Called functions will not.
> 
> Fixes: 09f79fd49d94 ("i40e: avoid NVM acquire deadlock during NVM
> update")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yes, this fixes the function header comment, not sure if it requires
the "Fixes:" tag.  If that were the case, wonder why all the other code
comment changes do not have this. :-)  I do agree it reads better with
this change, so I do not have an issue queue this up for Dave's net
tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170906/dcd1c398/attachment.asc>
