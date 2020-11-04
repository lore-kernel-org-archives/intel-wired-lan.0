From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 4 Nov 2020 15:33:20 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 1/6] i40e: introduce lazy Tx
 completions for AF_XDP zero-copy
In-Reply-To: <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed,  4 Nov 2020 15:08:57 +0100 Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Introduce lazy Tx completions when a queue is used for AF_XDP
> zero-copy. In the current design, each time we get into the NAPI poll
> loop we try to complete as many Tx packets as possible from the
> NIC. This is performed by reading the head pointer register in the NIC
> that tells us how many packets have been completed. Reading this
> register is expensive as it is across PCIe, so let us try to limit the
> number of times it is read by only completing Tx packets to user-space
> when the number of available descriptors in the Tx HW ring is below
> some threshold. This will decrease the number of reads issued to the
> NIC and improves performance with 1.5% - 2% for the l2fwd xdpsock
> microbenchmark.
> 
> The threshold is set to the minimum possible size that the HW ring can
> have. This so that we do not run into a scenario where the threshold
> is higher than the configured number of descriptors in the HW ring.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

I feel like this needs a big fat warning somewhere.

It's perfectly fine to never complete TCP packets, but AF_XDP could be
used to implement protocols in user space. What if someone wants to
implement something like TSQ?
