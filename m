From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 25 Jan 2022 00:48:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add waiting for
 response from PF in set mac
In-Reply-To: <20220124154553.29782-1-mateusz.palczewski@intel.com>
References: <20220124154553.29782-1-mateusz.palczewski@intel.com>
Message-ID: <028c789af62a63fbb64d96706ca0e36a57cbec39.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2022-01-24 at 16:45 +0100, Mateusz Palczewski wrote:
> Make iavf_set_mac synchronous by waiting for a response
> from a PF. Without this iavf_set_mac is always returning
> success even though set_mac can be rejected by a PF.
> This ensures that when set_mac exits netdev MAC is updated.
> This is needed for sending ARPs with correct MAC after
> changing VF's MAC. This is also needed by bonding module.

This sounds very much like this patch [1] or is this resolving a
different issue?

> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?
id=c5c922b3e09b6e5eeb9cd2b1122f3e49c0bf2283

