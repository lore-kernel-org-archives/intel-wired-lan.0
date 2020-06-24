From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 24 Jun 2020 06:23:57 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add LPI counters
In-Reply-To: <DM6PR11MB2890D64AD6055EB780EF3885BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200604112516.44949-1-sasha.neftin@intel.com>
 <DM6PR11MB2890D64AD6055EB780EF3885BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <5a821cd7-cd51-6725-34a3-2c4322ed35ba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2020 04:05, Brown, Aaron F wrote:
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Sasha Neftin
>> Sent: Thursday, June 4, 2020 4:25 AM
>> To: intel-wired-lan at lists.osuosl.org
>> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add LPI counters
>>
>> Add EEE TX LPI and EEE RX LPI counters. A EEE TX LPI event
>> occurs when the transmitter enters EEE (IEEE 802.3az) LPI
>> state. A EEE RX LPI event ocuurs when the receiver detect
>> link partner entry into EEE(IEEE 802.3az) LPI state.
> 
> Are these counters exposed anywhere I can view them?
Just added relevant LPI registers. EEE support only in initial phase, 
many stuff will be added later.
> 

