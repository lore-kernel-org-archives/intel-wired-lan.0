From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 09 Apr 2018 10:33:46 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v6 08/10] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C825976@ORSMSX101.amr.corp.intel.com>
References: <20180329210751.11531-1-vinicius.gomes@intel.com>
 <20180329210751.11531-9-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C824FA7@ORSMSX101.amr.corp.intel.com>
 <87h8opmt4m.fsf@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C825976@ORSMSX101.amr.corp.intel.com>
Message-ID: <874lkkl1xh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

[...]

>
>> 
>> I added that note in the hope that someone else would have an stronger
>> opinion about what to do.
>
> I don't have a strong opinion beyond my preference for an ideal world
> where everything works :)  If the part simply cannot filter on the src
> address as a whole without the protocol I would ideally prefer an
> attempt in ethtool to set the filter on src address as a whole to
> return an error WHILE still allowing the filter to be set on an
> ethertype when the proto keyword is issued.  If ethtool does not allow
> that fine grain of control then I think the way it is now is good, I'd
> rather have the annoyance of being able to set a filter that does
> nothing then not be able to set the more specific filter at all.

We are agreed. The next version of this series implements just that:
specifying the src address alone is an error, but if the classifier has
a src address and any other filter, it works.


Cheers,
--
Vinicius
