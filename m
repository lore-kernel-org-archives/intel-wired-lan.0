From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 7 Dec 2017 13:52:11 -0800
Subject: [Intel-wired-lan] [next-queue 06/10] ixgbe: restore offloaded
 SAs after a reset
In-Reply-To: <f8f1d753-3f29-6aa7-326c-423f38036877@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-7-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdOG5H02Tqin4OhEvp=6ZDn365g04JvVOVAiTyCnncPew@mail.gmail.com>
 <90efb41d-2cab-f623-8b3d-318f3ad6e135@oracle.com>
 <CAKgT0UfDFyH8qjg_-cdGYx5f06iTwydcMTcZ5FvhKJ+=2bNTLQ@mail.gmail.com>
 <f8f1d753-3f29-6aa7-326c-423f38036877@oracle.com>
Message-ID: <CAKgT0UfDnHnPCM8Px-TCbiB4wBQGN9CskftyF+4V=5g2F72QVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 7, 2017 at 10:47 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 12/7/2017 9:16 AM, Alexander Duyck wrote:
>>
>> On Wed, Dec 6, 2017 at 9:43 PM, Shannon Nelson
>> <shannon.nelson@oracle.com> wrote:
>>>
>>> On 12/5/2017 9:30 AM, Alexander Duyck wrote:
>>>>
>>>>
>>>> On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
>>>> <shannon.nelson@oracle.com> wrote:
>>>>>
>>>>>
>>>>> On a chip reset most of the table contents are lost, so must be
>
>
> <snip>
>
>>>>> +       /* reload the IP addrs */
>>>>> +       for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
>>>>> +               struct rx_ip_sa *ipsa = &ipsec->ip_tbl[i];
>>>>> +
>>>>> +               if (ipsa->used)
>>>>> +                       ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
>>>>> +               else
>>>>> +                       ixgbe_ipsec_set_rx_ip(hw, i, zbuf);
>>>>
>>>>
>>>>
>>>> If we are doing a restore do we actually need to write the zero
>>>> values? If we did a reset I thought you had a function that was going
>>>> through and zeroing everything out. If so this now becomes redundant.
>>>
>>>
>>>
>>> Currently ixgbe_ipsec_clear_hw_tables() only gets run at at probe.  It
>>> should probably get run at remove as well.  Doing this is a bit of safety
>>> paranoia, and making sure the CAM memory structures that don't get
>>> cleared
>>> on reset have exactly what I expect in them.
>>
>>
>> You might just move ixgbe_ipsec_clear_hw_tables into the rest logic
>> itself. Then it covers all cases where you would be resetting the
>> hardware and expecting a consistent state. It will mean writing some
>> registers twice during the reset but it is probably better just to
>> make certain everything stays in a known good state after a reset.
>
>
> If it is a small number, e.g. 10 or 20, then you may be right.  However,
> given we have table space for 2k different SAs, at 6 writes per Tx SA and 10
> writes per Rx SA, plus 128 IP address with 4 writes each, we are already
> looking at 17K writes already to be sure the tables are clean.
>
> Unfortunately, I don't really know what a "typical" case will be, so I don't
> know how many SA we may be offloading at any one time.  But in a busy cloud
> support server, we might have nearly full tables.  If we do the full clean
> first, then have to fill all the tables, we're now looking at up to 35k
> writes slowing down the reset process.
>
> I'd rather keep it to the constant 17K writes for now, and look later at
> using the VALID bit in the IPSRXMOD to see if we can at least cut down on
> the Rx writes.
>
> sln

The reads/writes themselves should be cheap. These kind of things only
get to be really expensive when you start looking at adding delays in
between the writes/reads polling on things. As long as we aren't
waiting milliseconds on things you can write/read thousands of
registers and not even notice it.

One thing you might look at doing in order to speed some of this up a
bit would be to also combine updating the Tx SA and Rx SA in your
clear_hw_tables loop so that you could do them in parallel in your
loop instead of having to do them in series. Anyway it is just a
thought. If nothing else you might look at timing the function to see
how long it actually takes. I suspect it shouldn't be too long since
the turnaround time on the PCIe bus should be in microseconds so odds
are reading/writing 35K registers might ovinly add a few milliseconds
to total reset time.
