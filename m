From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 11 May 2015 08:46:30 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] net: igb: add phy read/write
 functions that accept phy addr
In-Reply-To: <CAJ+vNU0a6tLspiJC7_-yenfCjiexrmJaH91_M+wH+6UJ0Z+NKg@mail.gmail.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>	<1430417955-28252-3-git-send-email-tharvey@gateworks.com>	<554D5DBA.9070109@gmail.com>
 <CAJ+vNU0a6tLspiJC7_-yenfCjiexrmJaH91_M+wH+6UJ0Z+NKg@mail.gmail.com>
Message-ID: <5550CED6.2000003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/11/2015 08:27 AM, Tim Harvey wrote:
> On Fri, May 8, 2015 at 6:07 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> On 04/30/2015 11:19 AM, Tim Harvey wrote:
>>> Add igb_write_reg_gs40g/igb_read_reg_gs40g that can be passed a phy
>>> address.
>>> The existing igb_write_phy_reg_gs40g/igb_read_phy_reg_gs40g become
>>> wrappers
>>> to this function.
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>
>> I'm pretty sure this isn't useful as well.  You really should not be doing
>> any phy address/MDICNFG manipulation in these calls.
> Alexander,
>
> This patch is to support phylib which requires mdio functions that can
> pass a phy address rather than take it from the e1000_phy_info
> structure.
>
> Tim

Tim,

You only require PHY address support if you support multiple addresses.  
From what I can tell you don't.  You lock it down to only one address 
via the mask field when you are initializing the phylib structures.

- Alex
