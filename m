From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 17 Nov 2015 19:15:34 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use ether_addr_equal
	instead of memcmp
In-Reply-To: <1447716814-4908-1-git-send-email-jacob.e.keller@intel.com>
References: <1447716814-4908-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1447787734.26111.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-11-16 at 15:33 -0800, Jacob Keller wrote:
> When comparing MAC addresses, use ether_addr_equal instead of memcmp
> to
> ETH_ALEN length. Found and replaced using the following sed:
> 
> ?sed -e 's/memcmp\x28\(.*\),
> ETH_ALEN\x29/!ether_addr_equal\x28\1\x29/'
> 
> Reported-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> Notes:
> 
> ????This replaces the version on the queue inline and corrects issues
> ????with all 4 tests that were replaced. It should fix the mailbox
> ????ethtool test among other possible issues.
> 
> ????- v2
> ????* correct sed expression and fix mis-use of ether_addr_equal


Testing Hints:

1) run the mailbox offline test on a VF
2) try to change VF mac address once it's been assigned by PF, this
should have been broken without this patch, and fixed now.

I think these are the two major things that were broken.

Regards,
Jake
