From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 28 Jul 2017 23:59:54 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] igbvf: after mailbox write,
 wait for reply
In-Reply-To: <20170720160058.8198-3-gedwards@ddn.com>
References: <20170720160058.8198-1-gedwards@ddn.com>
 <20170720160058.8198-3-gedwards@ddn.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C664708@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Greg Edwards
> Sent: Thursday, July 20, 2017 9:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Greg Edwards <gedwards@ddn.com>
> Subject: [Intel-wired-lan] [PATCH 2/2] igbvf: after mailbox write, wait for
> reply
> 
> Two of the VF mailbox commands were not waiting for a reply from the PF,
> which can result in a VF mailbox timeout in the VM for the next command.
> 
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
>  drivers/net/ethernet/intel/igbvf/vf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
