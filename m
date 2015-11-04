From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2015 01:06:36 +0200
Subject: [Intel-wired-lan] [PATCH v5] i40e: Look up MAC address in Open
	Firmware or IDPROM
In-Reply-To: <FC41C24E35F18A40888AACA1A36F3E418AFAEA1A@fmsmsx115.amr.corp.intel.com>
References: <20151104193956.GD14575@oracle.com>
 <CAHp75Vcrx+Rkz2mDSG+GEUW6LdO0w6On=6UoV4fhZK27Ayf1zQ@mail.gmail.com>
 <FC41C24E35F18A40888AACA1A36F3E418AFAEA1A@fmsmsx115.amr.corp.intel.com>
Message-ID: <CAHp75VfiveeZQ=gKDo7ZbySowrxxNNaC7=ZQriU0m-oVEQ92Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 5, 2015 at 12:53 AM, Nelson, Shannon
<shannon.nelson@intel.com> wrote:
>> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
>> Sent: Wednesday, November 04, 2015 11:59 AM
>>
>> On Wed, Nov 4, 2015 at 9:39 PM, Sowmini Varadhan
>> <sowmini.varadhan@oracle.com> wrote:
>> >
>> > This is the i40e equivalent of commit c762dff24c06 ("ixgbe: Look up MAC
>> > address in Open Firmware or IDPROM").
>
> [...]
>
>> > +       }
>> > +
>> > +       memset(&element, 0, sizeof(element));
>> > +       ether_addr_copy(element.mac_addr, macaddr);
>> > +       element.flags = cpu_to_le16(I40E_AQC_MACVLAN_ADD_PERFECT_MATCH);
>> > +       ret = i40e_aq_add_macvlan(&vsi->back->hw, vsi->seid, &element,
>> 1, NULL);
>> > +       aq_err = vsi->back->hw.aq.asq_last_status;
>>
>> Do you really need a separate variable (aq_err)?
>
> These are two separate error values that we're tracking - one from the communication between the driver and the firmware (aq_err) and one from the driver activity.  Sometimes there may be an AQ error that we want to report, but it might not actually be a driver error.  Alternatively, there are times when the AQ error needs to get interpreted different ways depending on which task the driver is performing.  Lastly, the AQ error gives us more detail on whatever the transaction error may have been which gives us more useful debug info.

Understandable, though in this certain function I don't see why we
can't drop it. The usage of it like this:

var x;

x = y;
if (x) {
...
}

Which is just
if (y) {
...
}


>
> sln



-- 
With Best Regards,
Andy Shevchenko
