From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 8 Nov 2016 22:04:23 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ptp: igb: Use the high
 resolution frequency method.
In-Reply-To: <b1d732324e0b1960b294e90ca5eb2a31b6559188.1478526333.git.richardcochran@gmail.com>
References: <cover.1478526333.git.richardcochran@gmail.com>
 <b1d732324e0b1960b294e90ca5eb2a31b6559188.1478526333.git.richardcochran@gmail.com>
Message-ID: <1478642646.7545.39.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-11-08 at 22:49 +0100, Richard Cochran wrote:
> The 82580 and related devices offer a frequency resolution of about
> 0.029 ppb.??This patch lets users of the device benefit from the
> increased frequency resolution when tuning the clock.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> ---

Additionally, what about min/max frequency check? Wouldn't this need to
be updated for the new adjfine operation?

Thanks,
Jake
