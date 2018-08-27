From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 27 Aug 2018 10:04:18 +0300
Subject: [Intel-wired-lan] [PATCH v6 02/11] igc: Add support for PF
In-Reply-To: <f39c245f-ba0b-5f88-4faa-09d04961458b@oracle.com>
References: <20180823070554.12243-1-sasha.neftin@intel.com>
 <f39c245f-ba0b-5f88-4faa-09d04961458b@oracle.com>
Message-ID: <96a43ca0-0cd9-de16-e933-e130aa858f4e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/23/2018 19:37, Shannon Nelson wrote:
> On 8/23/2018 12:05 AM, Sasha Neftin wrote:
> 
> [...]
> 
>> +#define array_wr32(reg, offset, value) \
>> +??? wr32((reg) + ((offset) << 2), (value))
>> +
>> +#define array_rd32(reg, offset) (igc_rd32(hw, (reg) + ((offset) << 2)))
>> +
> 
> Hmm... you may want to be careful with these array defines.? I don't 
> know what the register set looks like, but on some devices I've seen 
> array element offset is in things like 128 byte chunks rather than 
> 4-byte words.
> 
> sln
> 
Good point. We use this define for read array of 32 bit registers. Also, 
I will add validation request to double check how it work.
Thanks,
Sasha
