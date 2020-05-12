From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 12 May 2020 10:33:27 -0700
Subject: [Intel-wired-lan] [RFC PATCH] igc: Reject NFC rules with
 multiple matches
In-Reply-To: <20200429214306.71046-1-andre.guedes@intel.com>
References: <20200429214306.71046-1-andre.guedes@intel.com>
Message-ID: <158930480743.38976.12790388485955040034@ksengupt-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> The way rx queue assignment based on mac address, ethetype and vlan
> priority filtering operates in I225 doesn't allow us to properly support
> NFC rules with multiple matches.
> 
> Consider the following example which assigns to queue 2 frames matching
> the address MACADDR *and* ethertype ETYPE.
> 
> $ ethtool -N eth0 flow-type ether dst <MACADDR> proto <ETYPE> queue 2
> 
> When such rule is applied, we have 2 unwanted behaviors:
> 
>     1) Any frame matching MACADDR will be assigned to queue 2. It
>        doesn't matter the ETYPE value.
> 
>     2) Any accepted frame that has ethertype equals to ETYPE, no matter
>        the mac address, will be assigned to queue 2 as well.
> 
> While we could fix 1) by not enabling queue assignment on the MAC
> address filter, 2) would still happen.
> 
> In current code, multiple-match filters are accepted by the driver, even
> though it doesn't support them properly. This patch adds a check for
> multiple-match rules in igc_ethtool_is_nfc_rule_valid() so they are
> rejected.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
> Hi folks,
> 
> This patch was originally included in the series "igc: Fixes to NFC support
> code", but since it changes the way the driver interacts with user space, I
> decided to sent it separately as RFC to collect your opinions.
> 
> The patch description gives a detailed explanation about the issue. The bottom
> line is: Current code silently accepts a configuration that is not supported.
> This patch changes the driver so EOPNOTSUPP is returned instead of success.
> 
> What I'd like to get your feedback on is:
> 
> Is this considered an user-kernel break? If so, what would be the best way to
> move forward. Keep accepting the configuration but warn user via log message
> about not supporting it?

I'm assuming this is not considered a user-kernel break since I could spot at
least one similar change in igb driver (b4a38d4276e1). I'll rebase and send
this as PATCH.

- Andre
