From: Shannon Nelson <snelson@pensando.io>
Date: Mon, 31 Jan 2022 10:04:40 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220131172450.4905-1-saeed@kernel.org>
References: <20220131172450.4905-1-saeed@kernel.org>
Message-ID: <e9e124b0-4ea0-e84c-cd8e-1c6ad4df9d74@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/31/22 9:24 AM, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> NET_VENDOR_XYZ were defaulted to 'y' for no technical reason.
>
> Since all drivers belonging to a vendor are supposed to default to 'n',
> defaulting all vendors to 'n' shouldn't be an issue, and aligns well
> with the 'no new drivers' by default mentality.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>

Is there a particular reason to change this?
Broken compiles?? Bad drivers?? Over-sized output?

sln

