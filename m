From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 16 Sep 2015 14:09:02 -0700
Subject: [Intel-wired-lan] [next-queue 1/8] e1000: clean up the useless
 'continue' statement
In-Reply-To: <F274D7F1-7F0F-4C42-95BB-47E22E9DB386@intel.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
 <1442212070-24937-2-git-send-email-sakiwit@gmail.com>
 <32D3D43C-B677-4C70-8915-3B07B1175C66@intel.com>
 <20150915053501.GA3881@mail.gmail.com>
 <9EC98ADF-EA6D-4BDC-A442-F42BB805FA84@intel.com>
 <20150916153428.GB3881@mail.gmail.com> <55F99B1B.1010504@gmail.com>
 <F274D7F1-7F0F-4C42-95BB-47E22E9DB386@intel.com>
Message-ID: <55F9DA6E.8090300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 09/16/2015 11:27 AM, Rustad, Mark D wrote:
>> On Sep 16, 2015, at 9:38 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>
>> I kind of like Mark's idea better, though I would make one change.  I would make it so that you pull the check for i outside the loop so you have something like:
>> 		for (i = 0; i < 32; i++) {
>> 			hw->phy_addr = i;
>> 			e1000_read_phy_reg(hw, PHY_ID2, &tmp);
>>
>> 			if (tmp != 0 && tmp != 0xFF)
>> 				break;
>> 		}
>>
>> 		if (i >= 32)
>> 			goto no_err;
> Shouldn't that goto target be err_eeprom?

You're right.  My goof there.

>> This way you should only have to ever do a comparison of i once per loop, and hopefully the compiler is smart enough to realize that i >= 32 is the exit condition for the loop and will place the jump to that label accordingly.
> Yes, obviously I prefer the above form, with the corrected goto target, since that is what I described. The only difference being >= vs = and thought shouldn't matter. With >= being the logical opposite of the loop end test, it is probably the better choice.

I originally wrote it as == but the >= is the more explicit. Normally 
the loop would probably do a cmp followed by a jb to repeat the loop.

>> As a side note I am curious if this code is even correct.  I see tmp is a u16, the declaration for which could be moved down into the if statement if I am not mistaken, and I am curious as to why we are comparing it to 0xFF instead of 0xFFFF.  I suspect that the 0xFF check might not be adding any value, but I could be wrong.
> Yow! That is a really good question that I don't have an immediate answer to, having no experience with the internals of the e1000 driver and the devices it supports. Some research is required to answer that question.

I have a very strong suspicion that the 0xFF value is an error, but I 
don't see the documentation for the ce4100 anywhere to be had on where 
they came up with that value.  If it is supposed to be the result of a 
register read failure I believe the result would already be 0 since 
there is a flag in the register that indicates a read status failue and 
if it is set the value isn't stored.

- Alex
