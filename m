From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 9 Nov 2016 14:15:11 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ptp: igb: Use the high
 resolution frequency method.
In-Reply-To: <1478642646.7545.39.camel@intel.com>
References: <cover.1478526333.git.richardcochran@gmail.com>
 <b1d732324e0b1960b294e90ca5eb2a31b6559188.1478526333.git.richardcochran@gmail.com>
 <1478642646.7545.39.camel@intel.com>
Message-ID: <20161109131511.GB6491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 08, 2016 at 10:04:23PM +0000, Keller, Jacob E wrote:
> Additionally, what about min/max frequency check? Wouldn't this need to
> be updated for the new adjfine operation?

In theory you might increase the max by some sub-ppb value, but we
cannot express that as the resolution of the user space interface is
in ppb, and that little extra is not important anyhow.

Thanks,
Richard
