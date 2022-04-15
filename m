From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 Apr 2022 13:56:31 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Treat 1G Cu SFPs as 1G SX
 for X550EM
In-Reply-To: <20220414201329.27714-1-jeffd@silicom-usa.com>
References: <20220414172020.22396-1-jeffd@silicom-usa.com>
 <20220414201329.27714-1-jeffd@silicom-usa.com>
Message-ID: <5f4c6fe9-0b4b-5474-50a6-bf9a6bbc3b9f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/14/2022 1:13 PM, Jeff Daly wrote:
> X550EM NICs do not support 1G Cu SFPs by default from Intel, this patch
> enables treating these SFPs as 1G SX SFPs via a module parameter similar to
> the parameter that allows the driver to be able to recognize unsupported
> (by Intel) SFPs.

The addition of new module parameters is no longer allowed.

Thanks,

Tony

> Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
>
