class ContractPdf < Prawn::Document
	def initialize(project)
		super()
		@p = project

		title
		font_size(9) do
			project_head
			content
			signatures
			footer
		end

	end

	def title
		pad_bottom(10){text "Habitat Landscapes Ltd - Standard Works Contract #{Date.today.year}", size: 14, style: :bold}
	end

	def project_head
		stroke_horizontal_rule
		
			text_box "Project Reference:", :at =>[0, y - 40]
			text_box "<b>#{@p.reference}</b>", :inline_format => true, :at =>[100, y - 40]

			text_box "Customer Name:", :at =>[0, y - 54]
			text_box "<b>#{@p.first_name + " " + @p.last_name}</b>", :inline_format => true, :at =>[100, y - 54]

			text_box "Project Location:", :at =>[0, y - 68]
			text_box "<b>#{@p.post_code}</b>", :inline_format => true, :at =>[100, y - 68]

			text_box "Final Quote:", :at =>[0, y - 82]
			text_box "<b>£#{@p.quote}</b>", :inline_format => true, :at =>[100, y - 82]
	
		move_down(58)
		stroke_horizontal_rule
	end

	def content
		pad_top(10){text "This document outlines the basis of which Habitat Landscapes Ltd will carry out work for you. Although it appears lengthy, it contains important information relating to the obligations of both us as your installer, and youself as the custmoer so please take the time to read it carefully. Timestamp <b>#{Time.now.strftime("%R %d %B %Y")}</b>.", :inline_format => true}

		pad_top(5){text "For the rest of this document, <b>'We/Us/Our'</b> refers to Habitat Landscapes Ltd, and <b>'You/Your/Customer'</b> refers to the name printed at the head of this contract. <b>'Work'</b> refers to the specification detailed in the quotation provided previously with the project reference <b>#{@p.reference}</b>.", :inline_format => true }

		pad_top(10){text "Contracting & Subcontracting", :style => :bold}
		pad_top(5){text "Although we will carry out the majority of the work for you, we may for the sake of safety and/or quality choose to employ the services of subcontractors where we deem it nessesary. An exmaple of this may be for such work as electrics where lighting is included in the quote specification.", :inline_format => true }

		pad_top(10){text "Charges", :style => :bold}
		pad_top(5){text "Our quotation sets out the charges and fees for the agreed work to be undertaken. Unless agreed otherwise in writing, all sections of work are to be undertaken. Should it be agreed between us and you that any section of work is to be removed, it may NOT result in the full deduction of that sections allocated costs due to resource sharing between sections of work. We will notify you of any available deduction resulting from removal of sections of work.

			Although every effort has been made by us to foresee all eventualities in undertaking the work, it is possible that additional costs may arise from unforeseen circumstances outside of our control. In this unlikely event, we would notify you of the additional work required as soon as possible along with any associated costs, and would agree these with you before undertaking any of the additional work.", :inline_format => true }

		pad_top(10){text "Payment", :style => :bold}
		pad_top(5){text "A 10% deposit (<b>£#{@p.quote * 0.1}</b>) is required upon agreement of this contract to book your work into an available slot. A further 40% deposit (<b>£#{@p.quote * 0.4}</b>) is required 7 days prior to the commencment of your work. This enables us to reserve your job and order any necessary materials and/or equipment. The settlement figure of the remaining 50% (<b>£#{@p.quote * 0.5}</b>) plus any agreed costs for additional work, will be invoiced at the end of the work. Payment should be received by cheque, cash, or bank transfer <b>within 7 days</b> of the date of the invoice. Payment to be made within <b>7 days after</b> invoice date. Outstanding balances will be subject to <b>7% interest</b> from that date, on a monthly basis thereafter. Any payments should be made to the account of Habitat Landscapes Ltd. Account number: 93498220. Sort code: 20-05-74. If your cheque is stopped, any charges incurred by us will be recovered from you.", :inline_format => true }

		pad_top(10){text "Timescale", :style => :bold}
		pad_top(5){text "We will endeavor to give an approximate timescale for the specified work. However due to the nature of our business this may not always be 100% accurate. We will not be held liable for delays caused by you or any unforeseen circumstances outside of our control (e.g. adverse weather, ground conditions, supplier delays, faulty products, etc)", :inline_format => true }

		pad_top(10){text "Services", :style => :bold}
		pad_top(5){text "We reserve the right to make changes to our services which are necessary to comply with any applicable law or safety requirements. We will always notify you of such changes and warrant that at all times we will apply reasonable care and skill to our work.", :inline_format => true }

		pad_top(10){text "Materials", :style => :bold}
		pad_top(5){text "For the sake of this section <b>'materials'</b> refer to any nessesary product supplied for the undertaking of your work.

			A portion of the materials being supplied for your work have received your prior approval and have been priced into your quote. We may have made recommendations to use certain materials due to their proven and trusted quality, however you are free to ask us to use materials from other suppliers if required, but we will not use any supplier who we are not fully confident with, and will pass on any additional costs for products that become more expensive as a result of using your own suggested suppliers unless already agreed in the quote/specification. If you insist on a product contrary to our advice which turns out to be unfit for purpose, we cannot be held liable for any defects, future failures, or costs inccured as a result. 

			<b>Natural products</b> such as stone and timber; we cannot be held liable for any adverse effects that the surrounding environment may have on these products after installation. All products require maintenance to keep them at their best. We will always endevour to advise on nessesary maintenance, or you can find out more on our website.", :inline_format => true }

		pad_top(10){text "Hazards", :style => :bold}
		pad_top(5){text "It is your responsibility to inform us of any physical hazards or controlled waste substances present at the project location. Any expenses incurred through discovery of such hazards or substances may be billed to you if it has not been explicitly documented in your quotation specification. Such hazards and substances include sub-surface structures, controlled waste materials, presence of invasive species, etc. We do not actively seek out these hazards during our visits, however should we have noticed anything during our short site visits we would have notified you and included it in our costings at the time of compiling your quote. A lack of expicit reference to the presence of any such hazrads by us in any correspondance to this date, should be taken by you as our notice of not being aware of anything.", :inline_format => true }

		pad_top(10){text "Access", :style => :bold}
		pad_top(5){text "By signing this agreement you confirm that you will provide us, our emplyees, subcontractors and agents with access to your premises and any relevant information as required to carry out the work. 

		If works at the job location are to be carried out over two or more days, you confirm that you will keep and maintain all materials in safe custody and not dispose of anything without written consent from us. We will make every effort to ensure that all materials of worth will be stored out of view where possible and covered. We recommend keeping access to the project location secured outside of working hours, whilst materials are stored there. We take full and sole responsibility for any tools stored on site; they will be covered by our insurances.

		We are unable to take responsibility for ground damage arising from necessary vehicle or pedestrian passage. Please notify us of any changes in site conditions between the initial quote and the work commencement date in ample time. Failure to do so may cause extra costs to be incurred and these will be met by you. All precautions will be taken to avoid any unnecessary damage

		It is assumed under this agreement that unless otherwise explicity stated, you will provide us with access to power and water for the duration of the work. Failure to notify us immediately of the unavailability of such services may result in additional costs to enable the continuation or general undertaking of the work, and in a worst case may result in work being suspended or terminated.", :inline_format => true }

		pad_top(10){text "Termination of contract", :style => :bold}
		pad_top(5){text "You reserve the right to ask us to cease operations at any time but any costs incurred to that point in time will be recovered from you. You will be invoiced for the work carried out to date and the materials ordered up to the date on which you exercise your right to terminate. We also reserve the right to terminate this contract at any time; any costs incurred for labour up to this point will be at our expense however costs for any materials already purchased and left in your possesion may be recovered from you.", :inline_format => true }

		pad_top(10){text "Complaints", :style => :bold}
		pad_top(5){text "We are sure you will be extremely happy with the final result and we pride ourselves on client satisfaction. However, if any works are unsatisfactory please notify us within 28 days of the final invoice date. We will attempt to rectify any defects without charge providing all after care advice as stated on our website at www.habitatlandscape.co.uk has been adhered to and the defect does not fall under any other clause of this contract. In the unlikely event that you are still not satisfied we ask that you please put your complaint in writing to us. If you are unhappy with the response please refer your complaint to Marshalls Customer care line: 08458205000.  If you do not notify us within 28 days from the final invoice date of any unsatisfactory works then we will deem this your satisfactory acceptance of the works completed.", :inline_format => true }

		pad_top(10){text "Acceptance", :style => :bold}
		pad_top(5){text "By signing and returning this contract to us, in association with the corresponding quotation, this will be held as acceptance of the Terms and Conditions implied within. Except as set out in these conditions, all warranties, conditions and other terms implied by statute or common law are excluded from the Contract.

	Finally, we look forward to working with you soon and should you have any queries regarding any of the above please do not hesitate to get in touch. We are sorry that such formalities are needed yet such terms are intended to protect not only ourselves, but most importantly you as our client.", :inline_format => true }

	end

	def signatures
		pad_top(10){text "Signatures"}
	end

	def footer
		pad_top(10){text "Footer"}
	end

end