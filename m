From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 06 Mar 2018 13:26:05 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 8/8] igb: Add support
 for adding offloaded clsflower filters
In-Reply-To: <20180306112806.6fa39148@cakuba.netronome.com>
References: <20180302184344.5744-1-vinicius.gomes@intel.com>
 <20180302184344.5744-9-vinicius.gomes@intel.com>
 <20180305131350.326a886d@cakuba.netronome.com> <87muzl10ph.fsf@intel.com>
 <20180306112806.6fa39148@cakuba.netronome.com>
Message-ID: <87d10g28wi.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Jakub Kicinski <kubakici@wp.pl> writes:

> On Tue, 06 Mar 2018 11:08:26 -0800, Vinicius Costa Gomes wrote:
>> >> +static int igb_parse_cls_flower(struct igb_adapter *adapter,
>> >> +				struct tc_cls_flower_offload *f,
>> >> +				int traffic_class,
>> >> +				struct igb_nfc_filter *input)
>> >> +{
>> >> +	if (f->dissector->used_keys &
>> >> +	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
>> >> +	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
>> >> +	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
>> >> +	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
>> >> +		dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%x\n",
>> >> +			f->dissector->used_keys);  
>> >
>> > This will probably trigger for opportunistic offload (non-skip_sw) and
>> > confuse users.
>> 
>> I see your point. I will change to 'dev_warn()', it should not surprise
>> users too much, right?
>
> Yes, I think that would be fine, other drivers are doing that already.
>
> IMHO best approach is to not print anything unless skip-sw is set.  If
> you used netlink's extack capability exclusively it would "just work".
> Extack will only carry the error in case offload is requested.  Could
> you consider using extack or do you have a preference to print into the
> logs?  You could do both, too.

I will go with extack-only, but I had to tweak the message a little as
there's no support for format strings in extack.

>
> You can get to extack via f->common->extack.


Cheers,
--
Vinicius
