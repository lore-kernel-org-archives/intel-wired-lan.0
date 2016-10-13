From: Chris Arges <carges@vectranetworks.com>
Date: Thu, 13 Oct 2016 13:56:42 +0000
Subject: [Intel-wired-lan] Bug with 'igb: Remove GS40G specific
 defines/functions'
In-Reply-To: <1476349095.18484.15.camel@maxwell>
References: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
 <1570773976.567827.1476303559656.JavaMail.zimbra@xes-inc.com>
 <20F028E5-EC20-4F65-8889-3F254196ABF8@vectranetworks.com>
 <133564642.602581.1476305193640.JavaMail.zimbra@xes-inc.com>
 <F267652D-6FE2-4808-BFE7-013510C5A733@vectranetworks.com>
 <1476349095.18484.15.camel@maxwell>
Message-ID: <1749CC13-EEFE-4EEB-B74E-40B563D7230C@vectranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/13/16, 3:58 AM, "Jochen Henneberg" <jh@henneberg-systemdesign.com> wrote:

    On Mi, 2016-10-12 at 21:18 +0000, Chris Arges wrote:
    > 
    > On 10/12/16, 3:46 PM, "Aaron Sierra" <asierra@xes-inc.com> wrote:
    > 
    >     Chris,
    >     
    >     > I?m not sure exactly which part I need to comment out to verify in
    >     > ?igb_init_phy_params_82575()?.
    >     > Is there a fix already planned for this? Any additional information I can
    >     > provide?
    >     
    >     Did you follow any of the "Next message" links? There is more to the
    >     discussion than that first page that I linked to.
    >     
    >     In that discussion we determined that the PHY was somehow setup with a
    >     non-zero register page setting. That was treated as a BIOS bug rather
    >     than a driver bug.
    >     
    >     If you're having the same problem, then it could be possible to explicitly
    >     set the default page to zero, but I'm not sure where that _should_ be done
    >     or if that is generally the correct/safe thing to do.
    >     
    >     -Aaron
    >     
    > Aaron,
    > Ah sorry about that, I thought you were referring just to that particular post.
    > I?ll forward this along to the BIOS vendor.
    > Thanks,
    > --chris
    
    Chris,
    
    I was the original reporter of that issue. Find attached the patch that
    I currently use to ensure correct page selection before the
    configuration is started (id read).
    I am not sure if this is a good fix (though it is quite small which I
    would assume makes it good) and it applies to 4.5 kernel, I did not test
    with current head.
    The chips datasheet says that the initial page selection is 0, so this
    is assumed to be obsolete, but the BIOS may mess up things and as not
    everybody has means to modify or request a BIOS update it might make
    sense to bring this patch into the driver. It comes with almost no cost
    from what I can see.
    Please let me know if this fixes your problem.
    
    Regards
    -Jochen
    

Jochen,

Thanks for this update. I tested this patch and it fixes my issue!
If there are no other ill effects from this patch perhaps it would be a good
candidate for mainline and stable.

--chris



    
    > 
    > _______________________________________________
    > Intel-wired-lan mailing list
    > Intel-wired-lan at lists.osuosl.org
    > http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
    
    -- 
    Henneberg - Systemdesign
    Jochen Henneberg
    Loehnfeld 26
    21423 Winsen (Luhe)
    --
    Fon: +49 4174 668 773
    Mobile: +49 172 160 14 69
    Fax: +49 321 210 761 64
    www: www.henneberg-systemdesign.com
    
    
    

