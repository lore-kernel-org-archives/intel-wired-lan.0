From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Mon, 30 Jul 2018 19:56:36 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Prevent unsupported
 configurations with XDP
In-Reply-To: <20180730225248.42639-1-anthony.l.nguyen@intel.com>
References: <20180730225248.42639-1-anthony.l.nguyen@intel.com>
Message-ID: <20180730195636.28201146@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 30 Jul 2018 15:52:48 -0700, Tony Nguyen wrote:
> These changes address comments by Jakub Kicinski on
> commit 38b7e7f8ae82 ("ixgbe: Do not allow LRO or MTU change with XDP").
> 
> Change the MTU check with XDP to allow any supported value and only
> reject those outside of the range as opposed to rejecting any change
> when XDP is active. In situations where MTU size is not supported,
> return -EINVAL instead of -EPERM.
> 
> Add checks when enabling SRIOV, DCB, or adding L2FW offloaded device
> as they are not supported with XDP.
> 
> CC: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
