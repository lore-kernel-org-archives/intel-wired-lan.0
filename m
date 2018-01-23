From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue, 23 Jan 2018 10:07:23 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 00/10] Time based packet
 transmission
In-Reply-To: <20180123052601.oqrh3cnwfpoxmsdg@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180123052327.sxr63h3wmva4fvm4@localhost>
 <20180123052601.oqrh3cnwfpoxmsdg@localhost>
Message-ID: <3977fbe2-0e96-25c2-1ade-afe1300119ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 01/22/2018 09:26 PM, Richard Cochran wrote:
> On Mon, Jan 22, 2018 at 09:23:27PM -0800, Richard Cochran wrote:
>> On Wed, Jan 17, 2018 at 03:06:11PM -0800, Jesus Sanchez-Palencia wrote:
>>> First, a baseline test was ran for 10 minutes with the plain kernel only:
>>>
>>> |                 | plain kernel @ 1ms |
>>> |-----------------+--------------------+
>>> | min (ns):       |    +4.820000e+02   |
>>> | max (ns):       |    +9.999300e+05   |
>>> | pk-pk:          |    +9.994480e+05   |
>>
>> ...
>>
>>> |                 |    tbs SW @ 1ms   |  tbs HW @ 1ms  | tbs HW @ 250 us |
>>> |-----------------+-------------------+----------------+-----------------|
>>> | min (ns):       |    +1.510000e+02  |  +4.420000e+02 |   +4.260000e+02 |
>>> | max (ns):       |    +9.977030e+05  |  +5.060000e+02 |   +5.060000e+02 |
>>> | pk-pk:          |    +9.975520e+05  |  +6.400000e+01 |   +8.000000e+01 |
>>
>> I wonder about these worst case measurements of 999 and 998
>> milliseconds.  It almost looks like you missed one entire period.
>   ^^^^
> microseconds
> 
>> Could this simply be a bug in the test setup?


Yes. From the data set of the tbs SW:

offset |      timestamp
-------+---------------------
(...)  |
10639  | 1516117448.058010639
9503   | 1516117448.059009503
10167  | 1516117448.060010167
9823   | 1516117448.061009823
9567   | 1516117448.062009567
997703 | 1516117448.062997703 ****
911719 | 1516117448.063911719
12655  | 1516117448.065012655
12399  | 1516117448.066012399
(...)

Since the period was 1ms, the highlighted entry should have arrived within the
[1516117448.063000000, 1516117448.063999999] range, so in this case it was
early. For the next runs, I will modify the test setup so the txtime is sent as
part of the packet payload and later taken into account by the post-processing
script that is calculating the offsets.


Thanks,
Jesus


>>
>> Thanks,
>> Richard
