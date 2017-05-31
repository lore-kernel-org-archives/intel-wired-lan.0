From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 31 May 2017 14:42:32 -0700
Subject: [Intel-wired-lan] [i40e] regression on TCP stream and TCP
	maerts, kernel-4.12.0-0.rc2
In-Reply-To: <1496238507.22688.4.camel@redhat.com>
References: <655ed9ab-853e-7497-9ea3-cc8d13f56043@redhat.com>
 <CAKgT0UcdJQWqr_zxxi36a6_3iMwBNow-YS723i7t6xsKvAqvCA@mail.gmail.com>
 <CAKgT0Ufb41o=WM=3DM9cwvrw9N5AFn-uL0p1gQB-m+D3BX3DKA@mail.gmail.com>
 <1496238507.22688.4.camel@redhat.com>
Message-ID: <CAKgT0Ucg9wHrKDBjQXKH6gziuinwcK9MO-jRC=0q60Lm-8vFqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 31, 2017 at 6:48 AM, Adrian Tomasov <atomasov@redhat.com> wrote:
> On Tue, 2017-05-30 at 18:27 -0700, Alexander Duyck wrote:
>> On Tue, May 30, 2017 at 8:41 AM, Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>> >
>> > On Tue, May 30, 2017 at 6:43 AM, Adam Okuliar <aokuliar@redhat.com>
>> > wrote:
>> > >
>> > > Hello,
>> > >
>> > > we found regression on intel card(XL710) with i40e driver.
>> > > Regression is
>> > > about ~45%
>> > > on TCP_STREAM and TCP_MAERTS test for IPv4 and IPv6. Regression
>> > > was first
>> > > visible in kernel-4.12.0-0.rc1.
>> > >
>> > > More details about results you can see in uploaded images in
>> > > bugzilla. [0]
>> > >
>> > >
>> > > [0] https://bugzilla.kernel.org/show_bug.cgi?id=195923
>> > >
>> > >
>> > > Best regards, / S pozdravom,
>> > >
>> > > Adri?n Toma?ov
>> > > Kernel Performance QE
>> > > atomasov at redhat.com
>> >
>> > I have added the i40e driver maintainer and the intel-wired-lan
>> > mailing list so that we can make are developers aware of the issue.
>> >
>> > Thanks.
>> >
>> > - Alex
>>
>> Adam,
>>
>> We are having some issues trying to reproduce what you reported.
>>
>> Can you provide some additional data. Specifically we would be
>> looking
>> for an "ethtool -i", and an "ethtool -S" for the port before and
>> after
>> the test. If you can attach it to the bugzilla that would be
>> appreciated.
>>
>> Thanks.
>>
>> - Alex
>
> Hello Alex,
>
> requested files are updated in bugzilla.
>
> If you have any questions about testing feel free to ask.
>
>
> Best regards,
>
> Adrian

So looking at the data I wonder if we don't have an MTU mismatch in
the network config. I notice the "after" has rx_length_errors being
reported. Recent changes made it so that i40e doesn't support jumbo
frames by default, whereas before we could. You might want to check
for that as that could cause the kind of performance issues you are
seeing.

- Alex
