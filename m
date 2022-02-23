From: naamax.meir <naamax.meir@linux.intel.com>
Date: Wed, 23 Feb 2022 09:01:37 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Correct NVM checksum
 verification flow
In-Reply-To: <20220203122149.3298840-1-sasha.neftin@intel.com>
References: <20220203122149.3298840-1-sasha.neftin@intel.com>
Message-ID: <c2fa57e5-7955-6268-9fb7-ea05183f80f1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/3/2022 14:21, Sasha Neftin wrote:
> Update MAC type check e1000_pch_tgp because for e1000_pch_cnp,
> NVM checksum update is still possible.
> Emit a more detailed warning message.
>
> Bugzilla:https://bugzilla.opensuse.org/show_bug.cgi?id=1191663
> Fixes: 4051f68318ca ("e1000e: Do not take care about recovery NVM checksum")
> Reported-by: Thomas Bogendoerfer<tbogendoerfer@suse.de>
> Signed-off-by: Sasha Neftin<sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220223/1f83995c/attachment-0001.html>
