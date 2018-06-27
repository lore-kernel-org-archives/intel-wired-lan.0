From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 27 Jun 2018 16:57:20 -0700
Subject: [Intel-wired-lan] [PATCH v3 02/11] igc: Add support for PF
In-Reply-To: <63d4f9f3-d9c7-64f2-9256-fca93e8383e7@oracle.com>
References: <20180624084500.10021-1-sasha.neftin@intel.com>
 <63d4f9f3-d9c7-64f2-9256-fca93e8383e7@oracle.com>
Message-ID: <4ffa6ee4-eef8-5ff1-205d-15a4e02fef05@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/26/2018 5:32 PM, Shannon Nelson wrote:
> On 6/24/2018 1:45 AM, Sasha Neftin wrote:

[...]

>> +
>> +/* forward declaration */
>> +struct e1000_hw;
>> +u32 igc_rd32(struct e1000_hw *hw, u32 reg);
> 
> Can we do this without the forward decls?
> 

Never mind - I missed that this is a .h file here.

sln
