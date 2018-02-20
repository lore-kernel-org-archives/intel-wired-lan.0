From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 19 Feb 2018 17:54:35 -0800
Subject: [Intel-wired-lan] e1000e driver won't set speed?
In-Reply-To: <CAKgT0UcSzHhMwt7SHt491c4OcsibBJitqUwDnsQ-CTtPFQ04Vw@mail.gmail.com>
References: <3f0e0d14-feb5-2b98-400b-42a5947bcb60@ubuntu.com>
 <CAKgT0UcSzHhMwt7SHt491c4OcsibBJitqUwDnsQ-CTtPFQ04Vw@mail.gmail.com>
Message-ID: <c11dfd4d-b008-2b85-12c4-a271748bfa11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/19/2018 17:14, Alexander Duyck wrote:
> On Mon, Feb 19, 2018 at 2:27 PM, Phillip Susi <psusi@ubuntu.com> wrote:
>> I have a cable drop in a room in my house that apparently has some bad
>> pairs.  I made sure to wire it such that the two good pairs it has are
>> the ones that 10BaseT needs.  I know that higher speeds need all pairs,
>> but 10BaseT should work fine with just the two.  It keeps trying and
>> failing to link, I think because it is trying to go to gigabit and that
>> won't work with only the two good pairs.
>>
>> I tried to force it to stay at 10 Mbps, but it doesn't work.  Why?  I
>> get the same results trying this on both a laptop and a desktop system
>> using the e1000e driver:
>>
>> ethtool -s enp0s31f6 speed 10
>> Cannot advertise speed 10
>>
>> Am I doing something wrong or is this a bug?
> 
> You will need to either turn off  "autoneg" or also provide a "duplex"
> option. So you should be able to get it to work with something like:
>      ethtool -s enp0s31f6 speed 10 duplex full
> 
> Thanks.
> 
> - Alex
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
in case you want work in half duplex mode probably you want use follow 
command: ethtool -s enp0s31f6 speed 10 duplex half autoneg off
Also, more appropriate place to submit your questions is 
e1000-devel at lists.sourceforge.net mailing list.
Thanks,
Sasha
