From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Sun, 7 Feb 2021 02:24:43 +0000
Subject: [Intel-wired-lan] 710/i40e, RSS and 802.1ad (double vlan)
In-Reply-To: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
References: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
Message-ID: <AB117487-C2C3-47EF-A3C4-FDCED9304282@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> On Feb 5, 2021, at 8:06 PM, dan at coverfire.com wrote:
> 
> ?When receiving 802.1ad traffic, the 710 puts it all on one queue by
> default which limits the scalability.
> 
> The use case I care about is simply skipping both VLAN headers to get
> the 5-tuple and select the RSS queue based on that.
> 
> I've tried to find a way to do this but have failed.
> 
> Can the hardware do this? Would a DDP package be able to do this?

Hi Dan, I am asking around to see what we can do, will get back to you in the coming week. 

--
Jesse Brandeburg

