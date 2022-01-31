From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 31 Jan 2022 09:59:05 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220131172450.4905-1-saeed@kernel.org>
References: <20220131172450.4905-1-saeed@kernel.org>
Message-ID: <20220131095905.08722670@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 31 Jan 2022 09:24:50 -0800
Saeed Mahameed <saeed@kernel.org> wrote:

> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> NET_VENDOR_XYZ were defaulted to 'y' for no technical reason.
> 
> Since all drivers belonging to a vendor are supposed to default to 'n',
> defaulting all vendors to 'n' shouldn't be an issue, and aligns well
> with the 'no new drivers' by default mentality.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

This was done back when vendors were introduced in the network drivers tree.
The default of Y allowed older configurations to just work.

So there was a reason, not sure if it matters anymore.
But it seems like useless repainting to change it now.
