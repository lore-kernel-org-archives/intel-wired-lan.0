From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 14 Mar 2022 11:42:31 -0700
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for double
 vlan in switchdev
In-Reply-To: <20220223003830.25565-1-martyna.szapar-mudlaw@intel.com>
References: <20220223003830.25565-1-martyna.szapar-mudlaw@intel.com>
Message-ID: <02787281-51d6-aab8-6047-59da1ad9658c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Martyna,

On 2/22/2022 4:38 PM, Martyna Szapar-Mudlaw wrote:
> Enable support for adding TC rules with both C-tag and S-tag that can
> filter on the inner and outer VLAN in QinQ for basic packets (not
> tunneled cases).
>
> Signed-off-by: Wiktor Pilarczyk <wiktor.pilarczyk@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>

It looks like this was based on changes made with the ice switch 
optimizations that were dropped for updating [1]. I have to drop this as 
well as it no longer applies without those. Please either rebase on 
current tree or wait for Alex's update and resend.

Thanks,

Tony

[1] 
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20220314/028137.html

